"""OM_sequence_controller_class"""
from OMPython import OMCSessionZMQ
import pandas as pd
import json
import os
from pathlib import Path
import shutil
from datetime import datetime, timezone
from pymongo import MongoClient
from abc import ABC, abstractmethod

class KibblePhase(ABC):
    """ Abstract class for the Kibble balance simulation phases. 
        This class is intended to be inherited by DynamicPhaseClass and StaticPhaseClass.
        It is manditory to have a load_simulate() method in the child classes."""
        
    def __init__(self,configuration):
        self.zeitstamp = datetime.now(timezone.utc)                                          # get the system time (in UTC)
        self.timestamp = self.zeitstamp.strftime("%Y%m%d%H%M%SZ") 

        # define the working directory
        self.temp_working_dir = "C:/Users/gregor.dudle/AppData/Local/Temp/Simulation_Bin/"   # temporary directory where OpenModelica can store the temporary files

        # base path of the Modelica Work
        self.base_dir = "C:/Users/gregor.dudle/OneDrive - OST/aFE/2026_Kibble/"              # Basic path for the Modelica work
        self.results_dir = self.base_dir + "Results/"
        self.kibble_dynamic_dir = self.base_dir+"Modelica_Work/DynamicPhase/"
        self.kibble_static_dir = self.base_dir+"Modelica_Work/StaticPhase/"
        
        # path for motion drivers
        self.driver_dir = self.base_dir + "Modelica_Work/Components/Motion_driver/"
        
        # Coil
        self.components_dir = self.base_dir + "Modelica_Work/Components/BIPM_Coil/"
        self.coil_model = configuration["coil"]

        # Magnetic field
        self.magnetic_dir = self.base_dir + "Modelica_Work/Components/BIPM_MagneticField/"
        # self.magnetic_field = configuration["magnetic_field"]
        # self.magnetic_field_filename = self.magnetic_dir + self.magnetic_field + ".csv"
        
        self.load_file_list = []        # array that will hold list of files to be loaded into OM
        
        
        self.kibble_balance_model = configuration["main"]
        
        
        # define the result filenames
        #   the OMPython will first write all outputs to workingDir+filename (=origin_file)
        #   and store the simulation result together with the provided metadata to results_dir + "Simulation_" + timestamp + "_res.json"
        #   if uncommented below the script will also copy the csv file to resultsDir
        self.origin_file = self.temp_working_dir + self.kibble_balance_model + "_res.csv"
        self.results_file_csv = self.results_dir + "Simulation_" + self.timestamp + "_res.csv"
        self.results_file_json = self.results_dir + "Simulation_" +self.timestamp + "_res.json"
        
        # create temp_working_dir 
        try:
            os.mkdir(self.temp_working_dir)
        except FileExistsError:
            print("Temporary directory already exists.")
            
        print(f"Simulation data and metadata will be stored in 'Simulation_{self.timestamp}_res.json'")
    
    @abstractmethod                 # this method MUST be implemented in the children classes
    def load_simulate(self):
        pass
        
    def list_to_dict(self,liste):
        """utility function to transform simulation option list to dict"""
        
        result = {}

        for item in liste:
            key, value = item.split("=", 1)
            key = key.strip()
            value = value.strip()

            # Remove surrounding quotes if present
            if (value.startswith("'") and value.endswith("'")) or \
            (value.startswith('"') and value.endswith('"')):
                value = value[1:-1]

            # Try converting to int or float
            else:
                try:
                    value = int(value)
                except ValueError:
                    try:
                        value = float(value)
                    except ValueError:
                        pass

            result[key] = value
        return result
    
    
class DynamicPhaseC01(KibblePhase):
    """ Class for the dynamic phase of the Kibble balance simulation.
        This class inherits from KibblePhase and implements the load_simulate() method."""
    
    def __init__(self,configuration):
        super().__init__(configuration)
        self.amplitude = configuration["motion"]["amplitude"]
        self.offset = configuration["motion"]["offset"]
        self.period = configuration["motion"]["period"]
        self.stopT = configuration["simulation"]["stopTime"]
        self.nbrInterv = configuration["simulation"]["numberOfIntervals"]
        print(f"Motion")
        print("------")
        print(f"Period: {self.period}")
        print(f"Amplitude: {self.amplitude}")
        print(f"Offset: {self.offset}")
        print()
        print(f"Simulation")
        print("----------")
        print(f"numberOfIntervals:{self.nbrInterv}")
        print(f"stopTime: {self.stopT}")
        
        self.x_driver_model = configuration["motion"]["driver"]
        
        # create the list of files to be loaded
        self.load_file_list = [
            self.kibble_dynamic_dir + self.kibble_balance_model + ".mo",
            self.components_dir + self.coil_model + ".mo",
            self.driver_dir + self.x_driver_model + ".mo"
        ]

        self.magnetic_field = configuration["magnetic_field"]
        self.magnetic_field_filename = self.magnetic_dir + self.magnetic_field + ".csv"
        
    def load_simulate(self):
        """ Required method.
            Loads the Modelica components and simulate the Kibble balance in the dynamic phase."""

        phase_model = OMCSessionZMQ()
        
        phase_model.sendExpression('loadModel(Modelica)')
        phase_model.sendExpression("cd(\""+self.temp_working_dir+"\")")

        for filename in self.load_file_list:
            try:
                print(f"Trying to load {filename} ... ", end= " ")
                phase_model.sendExpression(f"loadFile(\"{filename}\")")
                print(f"Success")
            except:
                print(f"Error loading file: {filename}")
                continue

        phase_model.sendExpression(f'translateModel({self.kibble_balance_model})')
        
        # The following lines are VERY complicated. Multiple quotes are required and in some cases quotes need to be escaped
        # The (parsed) command should be
        #    sendExpression('simulate(DynamicPhaseV03,stopTime=100.0),stopTime=100.0,numberOfIntervals=5000,
        #                    simflags="-override=peri=20,
        #                                       ampli=0.003,
        #                                       magTableFileName=\"C:/Users/gregor.dudle/OneDrive - OST/aFE/2026_Kibble/Modelica_Work/Components/BIPM_MagneticField/BIPM_magnetic_field_01.csv\" " '

        simflags = f'-override=peri={self.period},'\
                    f'ampli={self.amplitude},'\
                    f'magTableFileName=\\"{self.magnetic_field_filename}\\"'

        sim = phase_model.sendExpression(
            f'simulate({self.kibble_balance_model},'
            f'stopTime={self.stopT},'
            f'numberOfIntervals={self.nbrInterv},'
            f'simflags="{simflags}",'
            f'outputFormat="csv")'
        )

        #shutil.copy(origin_file,results_file_csv) # uncomment if the .csv is needed
        # collect metadata of the simulation and store them together with the simulation data in the file 'Simulation_xxxxxxxxxxx_res.json'
        metadata = {
            'id': self.timestamp,
            'date': datetime.today().strftime('%Y-%m-%d %H:%M:%S'),
            'user': os.getlogin(),
            'KibbleBalanceModel': self.kibble_balance_model,
            'CoilModel': self.coil_model,
            'MagneticField': self.magnetic_field,
            'Motion':{
                'Driver': self.x_driver_model,
                'Amplitude':self.amplitude,
                'Period':self.period,
                'Offset':self.offset,
            },
            
            'Simulation':  self.list_to_dict(str(sim["simulationOptions"]).split(", "))
            }

        df = pd.read_csv(self.origin_file)

        package ={
            'metadata':metadata,
            'data':df.to_dict(orient="records")
        }
        with open(self.results_file_json, "w", newline="") as f:
            w = f.write(json.dumps(package,indent=4))

        # add simulation to DB
        client = MongoClient("mongodb://localhost:27017/")
        DB = client["Simu_Data_Test"]
        collection = DB["Simu_Data"]
        collection.insert_one(metadata)
        
        
class StaticPhaseC01(KibblePhase):
    """ Class for the static phase of the Kibble balance simulation.
        This class inherits from KibblePhase and implements the load_simulate() method."""
    
    def __init__(self,configuration):
        super().__init__(configuration)

        self.stopT = configuration["simulation"]["stopTime"]
        self.nbrInterv = configuration["simulation"]["numberOfIntervals"]
        
        self.weight_period = configuration["weight_driver"]["period"]
        self.weight_amplitude = configuration["weight_driver"]["amplitude"]
        self.weight_rising= configuration["weight_driver"]["rising"]
        self.weight_width= configuration["weight_driver"]["width"]
        self.weight_falling= configuration["weight_driver"]["falling"]
        
        self.PID_k = configuration["PID"]["k"]
        self.PID_Td = configuration["PID"]["Td"]
        self.PID_Ti = configuration["PID"]["Ti"]
        
        print(f"Simulation")
        print("----------")
        print(f"numberOfIntervals:{self.nbrInterv}")
        print(f"stopTime: {self.stopT}")
        
        print(f"main: {configuration["main"]}")
        self.kibble_balance_model = configuration["main"]

        # create the list of files to be loaded
        self.load_file_list = [
            self.kibble_static_dir + self.kibble_balance_model + ".mo",
            self.components_dir + self.coil_model + ".mo"
        ]

        
    def load_simulate(self):
        phase_model = OMCSessionZMQ()
        
        phase_model.sendExpression('loadModel(Modelica)')
        phase_model.sendExpression("cd(\""+self.temp_working_dir+"\")")

        for filename in self.load_file_list:
            try:
                print(f"Trying to load {filename} ... ", end= " ")
                phase_model.sendExpression(f"loadFile(\"{filename}\")")
                print(f"Success")
            except:
                print(f"Error loading file: {filename}")
                continue
            
        print()
        print("Translate model and simulate ...",end = " ")
                
        phase_model.sendExpression(f'translateModel({self.kibble_balance_model})')
        
        print("done")
        
        print()
        print("Store metadata and results in DB and JSON file")
        
        simflags = f'-override=Driver.period={self.weight_period},'\
                    f'Driver.amplitude={self.weight_amplitude},'\
                    f'Driver.rising={self.weight_rising},'\
                    f'Driver.width={self.weight_width},'\
                    f'Driver.falling={self.weight_falling},'\
                    f'PID.k={self.PID_k},'\
                    f'PID.Td={self.PID_Td},'\
                    f'PID.Ti={self.PID_Ti}'

        sim = phase_model.sendExpression(
            f'simulate({self.kibble_balance_model},'
            f'stopTime={self.stopT},'
            f'numberOfIntervals={self.nbrInterv},'
            f'simflags="{simflags}",'
            f'outputFormat="csv")'
        )
        
        
        # phase_model.sendExpression("plot(coil.p.i)")      # example how to call plot window
        
        # collect metadata of the simulation and store them together with the simulation data in the file 'Simulation_xxxxxxxxxxx_res.json'
        metadata = {
            'id': self.timestamp,
            'date': datetime.today().strftime('%Y-%m-%d %H:%M:%S'),
            'user': os.getlogin(),
            'KibbleBalanceModel': self.kibble_balance_model,
            'WeightDriver':{
                'period': self.weight_period,
                'amplitude':self.weight_amplitude,
                'rising':self.weight_rising,
                'width':self.weight_width,
                'falling':self.weight_falling
            },
            'PID':{
                'k':self.PID_k,
                'Td':self.PID_Td,
                'Ti':self.PID_Ti
            },
            
            'Simulation':  self.list_to_dict(str(sim["simulationOptions"]).split(", "))
            }

        df = pd.read_csv(self.origin_file)

        package ={
            'metadata':metadata,
            'data':df.to_dict(orient="records")
        }
        with open(self.results_file_json, "w", newline="") as f:
            w = f.write(json.dumps(package,indent=4))

        # add simulation to DB
        client = MongoClient("mongodb://localhost:27017/")
        DB = client["Simu_Data_Test"]
        collection = DB["Simu_Data"]
        collection.insert_one(metadata)
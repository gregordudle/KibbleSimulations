# Readme
Description of the structure used for the Kibble Balance Simulation Environment. The environment is based on 
- [Experiments](#experiments)
- [Configurations](#configurations)
- [Classes](#classes)
- [Modelica models](#modelica-models)


2026-10-26, Dugr
### Experiments
The files `experiment_nnn.json` contain the sequence of configurations to be simulated in an array. *nnn* is a unique number identifying the sequence. The configurations are described in the file `configuration.json`. If the configuration referred to in the Experiment file is not defined in `configuration.json` this trigger an error.

##### Example
[
    "DynamicPhaseConf05",
    "StaticPhaseConf03"
]


### Configurations
The file `configurations.json`contains the description of all configurations that have been used in experiments. To ensure that a configuration can be reproduced later, the parameters of a configuration that has been used in simulations must not be changed. If parameters are to be changed, a configuration with a new label must be defined. 
##### Naming convention 
The configuration have a label 
- `DynamicConfyy` or  
- `StaticConfyy`  

In both cases _yy_ is a unique identifier.  

Two configurations can have the same list of parameters, but different value for these parameters (e.g. a different speed for the driver of the dynamic phase)

##### Example
    "DynamicPhaseConf05":
    {
        "class":"DynamicPhaseC01",
        "phase":"dynamic",
        "main":"DynamicPhaseM03",
        "coil": "BIPM_coil_2V4",
        "magnetic_field":"BIPM_magnetic_field_01",
        "motion":{
            "driver":"triangular_position",
            "amplitude":0.004,
            "offset":0,
            "period":25
        },
        "simulation":{
            "stopTime":100,
            "numberOfIntervals":1000
        }
    },

### Classes
For reasons of coding, a (Python) class needs to be defined for a given list of parameters. This is done in the module `KibbleClasses`. Two configurations that have a different list of parameters will necessarily have separate classes.   

All classes inherit from a generic class called `KibblePhase` and must implement the method `load_simulate`

##### Naming convention
The classes have a name 
- `DynamicCyy` or
- `StaticCyy`


### Modelica Models
Modelica models are the main Modelica modules that are run for a simulation. They are labeled 
- `DynamicPhaseMyy.mo` or
- `StaticPhaseMyy.mo`
If the modelling is changed, a new number must be attributed to the model.  

##### Naming convention
Modules are stored individually in files and must comply with filename conventions. The extension for Modelica modules is `.mo`. The first part of the Module name can be chosen freely, the last three character before the dot are Myy, where yy is a unique label. 

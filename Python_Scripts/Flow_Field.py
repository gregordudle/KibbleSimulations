import numpy as np
import matplotlib.pyplot as plt

# Parameter
lambda0 = 1.0     # Quellenstärke pro Längeneinheit
d = 0.75           # Längenausdehnung in y-Richtung
g = 0.2           # Abstand von Quelle zur zugehörigen Senke in x-Richtung
R = 2.0           # Abstand der beiden Quellen von x=0

# Gitter zur Visualisierung
x = np.linspace(-3, 3, 200)
y = np.linspace(-2, 2, 150)
X, Y = np.meshgrid(x, y)

# Diskretisierung der Linienquellen
N = 100
y_line = np.linspace(-d, d, N)
dy = y_line[1] - y_line[0]

# Funktion zur Berechnung des Geschwindigkeitsfeldes
def velocity_field(X, Y):
    u = np.zeros_like(X)
    v = np.zeros_like(Y)

    for yq in y_line:
        # --- Linkes Paar: Quelle bei -R, Senke bei -R - g ---
        rx1 = X + R          # Quelle bei x = -R
        ry1 = Y - yq
        r1_sq = rx1**2 + ry1**2
        u += lambda0 / (2*np.pi) * rx1 / r1_sq * dy
        v += lambda0 / (2*np.pi) * ry1 / r1_sq * dy

        rx2 = X + R + g      # Senke bei x = -R - g
        ry2 = Y - yq
        r2_sq = rx2**2 + ry2**2
        u -= lambda0 / (2*np.pi) * rx2 / r2_sq * dy
        v -= lambda0 / (2*np.pi) * ry2 / r2_sq * dy

        # --- Rechtes Paar: Quelle bei +R, Senke bei +R + g ---
        rx3 = X - R          # Quelle bei x = +R
        ry3 = Y - yq
        r3_sq = rx3**2 + ry3**2
        u += lambda0 / (2*np.pi) * rx3 / r3_sq * dy
        v += lambda0 / (2*np.pi) * ry3 / r3_sq * dy

        rx4 = X - R - g      # Senke bei x = +R + g
        ry4 = Y - yq
        r4_sq = rx4**2 + ry4**2
        u -= lambda0 / (2*np.pi) * rx4 / r4_sq * dy
        v -= lambda0 / (2*np.pi) * ry4 / r4_sq * dy

    return u, v

# Feld berechnen
U, V = velocity_field(X, Y)
speed = np.sqrt(U**2 + V**2)

# Plot
fig, ax = plt.subplots(figsize=(10, 6))
strm = ax.streamplot(X, Y, U, V, color=speed, linewidth=1, cmap='viridis', density=1.2)
fig.colorbar(strm.lines, label='Field strength')

# Quellen & Senken einzeichnen
ax.plot([-R]*N, y_line, 'r-', linewidth=3, label='N Left')
ax.plot([-R-g]*N, y_line, 'b-', linewidth=3, label='S Left')
ax.plot([R]*N, y_line, 'r-', linewidth=3, label='N Right')
ax.plot([R+g]*N, y_line, 'b-', linewidth=3, label='S Right')

# Achsen und Titel
ax.set_title('Magnetic flux density of two pairs, placed symmetrically on the x axis')
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_aspect('equal')
ax.legend(loc='upper right')
plt.tight_layout()
plt.show()

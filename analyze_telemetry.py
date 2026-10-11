import pandas as pd
import matplotlib.pyplot as plt

# Read the data recorded by Godot
data = pd.read_csv("telemetry.csv")

# Create the speed graph
plt.plot(data["time"], data["speed_kmh"])
plt.xlabel("Time (seconds)")
plt.ylabel("Speed (km/h)")
plt.title("Vehicle Speed vs Time")
plt.grid(True)
plt.show()

# ACCELERATION GRAPH

plt.figure()

plt.plot(data["time"], data["acceleration"])

plt.xlabel("Time (seconds)")
plt.ylabel("Acceleration (m/s²)")
plt.title("Vehicle Acceleration vs Time")

plt.axhline(0, color="gray", linestyle="--")
plt.grid(True)

plt.show()
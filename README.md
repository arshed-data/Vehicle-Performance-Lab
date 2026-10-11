# Vehicle Performance Lab

This is a small vehicle simulation project I built using Godot and Python.

I wanted to understand how a car's acceleration, braking and speed can be simulated, recorded and analyzed using data.

I first created a simple driving environment in Godot, added a car and a racetrack, and then started collecting vehicle data during driving.

## What I Built

- A 3D car that can accelerate, brake and steer
- A racetrack for driving tests
- Speed, acceleration and braking information on the screen
- Lap counter and lap timer
- Telemetry recording into CSV files
- Python scripts to analyze the recorded data

## Tools Used

- Godot and GDScript
- Python
- Pandas
- Matplotlib
- VS Code

## Testing and Results

I tested two different vehicle setups to see how changing the acceleration affects the driving behavior.

| Test | Original Setup | Modified Setup |
|---|---|---|
| Maximum speed | 21.6 km/h | 28.8 km/h |
| 0–20 km/h | 2.22 seconds | 7.58 seconds |

The original setup accelerated much faster. After changing the vehicle settings, the acceleration became slower and more gradual.

The tests were recorded during different driving sessions, so the results are mainly useful for understanding the behavior of my simulation.

## Graphs

### Acceleration Comparison

![Acceleration Comparison](results/acceleration_comparison.png)

### Speed Comparison

![Speed Comparison](results/speed_comparison.png)

## How to Run

Open the project in Godot and run the main scene.

Use the arrow keys to drive the car.

The simulation records telemetry in a CSV file, which can be analyzed using the Python scripts.

To install the Python libraries:

`pip install pandas matplotlib`

To run the analysis:

`python analyze_telemetry.py`

`python compare_performance.py`

## What I Learned

Through this project, I learned how to connect a simple 3D simulation with data analysis.

I also learned how changes in acceleration and braking settings affect the simulated car and how to visualize these changes using Python.

The vehicle physics are simplified, so this is a learning project rather than a realistic vehicle model.

I would like to improve the physics and add more detailed vehicle testing in the future.
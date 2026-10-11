import pandas as pd
import matplotlib.pyplot as plt

# Load our two driving recordings
baseline = pd.read_csv("baseline_telemtry.csv")
test_a = pd.read_csv("test_A_baseline.csv")

# Create comparison graph
plt.figure(figsize=(12, 6))

plt.plot(
    baseline["time"],
    baseline["speed_kmh"],
    label="Original Setup",
    linewidth=2
)

plt.plot(
    test_a["time"],
    test_a["speed_kmh"],
    label="Modified Setup",
    linewidth=2
)

plt.xlabel("Time (seconds)")
plt.ylabel("Speed (km/h)")
plt.title("Vehicle Performance - Speed Comparison")

plt.legend()
plt.grid(True)
plt.tight_layout()
plt.savefig("results/speed_comparison.png", dpi=200)
plt.show()

print("\nVEHICLE PERFORMANCE COMPARISON")

print("Original maximum speed:",
      round(baseline["speed_kmh"].max(), 2), "km/h")

print("Modified maximum speed:",
      round(test_a["speed_kmh"].max(), 2), "km/h")

plt.figure(figsize=(7, 5))

plt.bar(
    ["Original", "Modified"],
    [
        baseline["speed_kmh"].max(),
        test_a["speed_kmh"].max()
    ]
)

plt.ylabel("Maximum Speed (km/h)")
plt.title("Maximum Speed Comparison")
plt.grid(axis="y")
plt.tight_layout()

plt.show()

def acceleration_test(data, target_speed=20):
    # Find the first time the car reaches 20 km/h
    reached = data[data["speed_kmh"] >= target_speed]

    if reached.empty:
        return None

    end_index = reached.index[0]

    # Find the most recent near-zero speed before reaching target
    earlier = data.loc[:end_index]
    stopped = earlier[earlier["speed_kmh"] < 1.0]

    if stopped.empty:
        return None

    start_index = stopped.index[-1]

    start_time = data.loc[start_index, "time"]
    end_time = data.loc[end_index, "time"]

    return end_time - start_time


original_time = acceleration_test(baseline)
modified_time = acceleration_test(test_a)

print("\n0–20 KM/H ACCELERATION TEST")

print("Original setup:", original_time, "seconds")
print("Modified setup:", modified_time, "seconds")

plt.figure(figsize=(8, 5))

plt.bar(
    ["Original", "Modified"],
    [original_time, modified_time]
)

plt.ylabel("Time (seconds)")
plt.title("0–20 km/h Acceleration Comparison")
plt.grid(axis="y")

plt.tight_layout()
plt.savefig("results/acceleration_comparison.png", dpi=200)
plt.show()
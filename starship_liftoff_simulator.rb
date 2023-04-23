require 'decisiontree'

ENGINE_THRUST = 1900000.0 # Newtons
DRY_ROCKET_MASS = 120000.0 # kg
MAX_FUEL_MASS = 1200000.0 # kg
FUEL_FLOW_RATE = 0.685 # kg/second/engine
GRAVITY = 9.81 # m/s^2

# Define the decision tree
training_data = [
    [0.0, 1],
    [25.0, 1],
    [50.0, 1],
    [75.0, 1],
    [100.0, 2],
]
tree = DecisionTree::ID3Tree.new(['height', 'num_engines'], training_data, 1, :discrete)

# Train the decision tree
tree.train

# Initial conditions
fuel_mass = 0.0 # kg
total_mass = DRY_ROCKET_MASS + fuel_mass
acceleration = 0.0 # m/s^2
velocity = 0.0 # m/s
height = 0.0 # m
num_engines = 1 # Number of engines currently firing

# Simulate liftoff
while height < 100.0 # meters
    # Calculate thrust based on number of engines
    thrust = ENGINE_THRUST * num_engines
    # Calculate acceleration based on thrust and mass
    acceleration = thrust / total_mass - GRAVITY
    # Update velocity and height based on acceleration
    velocity += acceleration * 0.1 # 0.1 second time step
    height += velocity * 0.1 # 0.1 second time step
    # Update fuel mass based on fuel flow rate and number of engines
    if total_mass < MAX_FUEL_MASS
        fuel_mass += FUEL_FLOW_RATE * num_engines * 0.1 # 0.1 second time step
        fuel_mass = [fuel_mass, MAX_FUEL_MASS - DRY_ROCKET_MASS].min
    end
    # Update total mass based on dry mass and fuel mass
    total_mass = DRY_ROCKET_MASS + fuel_mass
    # Use the decision tree to determine the number of engines to use
    num_engines = tree.predict([[height, num_engines]])[0]
end

# Print results
puts "Reached %.2f meters of lift with %d engines and %.2f kg of fuel." % [height, num_engines, fuel_mass]

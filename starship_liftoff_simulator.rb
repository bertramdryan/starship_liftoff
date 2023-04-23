# Constants
ENGINE_THRUST = 1900000 # Newtons
DRY_ROCKET_MASS = 120000 # kg
MAX_FUEL_MASS = 1200000 # kg
FUEL_FLOW_RATE = 0.685 # kg/second/engine
GRAVITY = 9.81 # m/s^2
MIN_LIFTOFF_THRUST = 1.2 # Multiplier for minimum viable lift-off thrust

# Initial conditions
fuel_mass = 0 # kg
total_mass = DRY_ROCKET_MASS + fuel_mass
acceleration = ENGINE_THRUST * MIN_LIFTOFF_THRUST / total_mass - GRAVITY
velocity = 0
height = 0

# Simulate liftoff
while height < 30.48 # 100 feet in meters
  if total_mass < MAX_FUEL_MASS
    fuel_mass += FUEL_FLOW_RATE * MIN_LIFTOFF_THRUST
    fuel_mass = [fuel_mass, MAX_FUEL_MASS - DRY_ROCKET_MASS].min
  end
  
  total_mass = DRY_ROCKET_MASS + fuel_mass
  acceleration = ENGINE_THRUST * MIN_LIFTOFF_THRUST / total_mass - GRAVITY
  velocity += acceleration * 0.1 # 0.1 second time step
  height += velocity * 0.1 # 0.1 second time step
end

# Determine minimum viable lift-off thrust
min_thrust = ENGINE_THRUST * MIN_LIFTOFF_THRUST

# Simulate continued liftoff
while height < 100 # feet
  if total_mass < MAX_FUEL_MASS
    fuel_mass += FUEL_FLOW_RATE * 33
    fuel_mass = [fuel_mass, MAX_FUEL_MASS - DRY_ROCKET_MASS].min
  end
  
  total_mass = DRY_ROCKET_MASS + fuel_mass
  acceleration = ENGINE_THRUST * 33 / total_mass - GRAVITY
  velocity += acceleration * 0.1 # 0.1 second time step
  height += velocity * 0.1 # 0.1 second time step
end

puts "At 33 engines and #{fuel_mass} kg of fuel, reached #{height.round(2)} meters of lift."
puts "Minimum viable lift-off thrust: #{min_thrust.round(2)} Newtons."

# Set constants for the Starship rocket system
ORBITAL_LAUNCH_MOUNT_HEIGHT = 100 # feet
TOTAL_ENGINES = 33
ROCKET_WEIGHT = 1410000 # pounds
FUEL_DENSITY = 51.6 # pounds per gallon
FUEL_EFFICIENCY = 300 # seconds of specific impulse
PAYLOAD_WEIGHT = 10000 # pounds
GRAVITY_ACCELERATION = 32.174 # feet per second squared

# Calculate the minimum viable lift-off thrust
minimum_thrust = (ROCKET_WEIGHT + PAYLOAD_WEIGHT) * GRAVITY_ACCELERATION / TOTAL_ENGINES

# Simulate liftoff with incremental engine activation
current_height = 0
current_thrust = 0
current_engines = 0
fuel_gallons = 0
while current_height < ORBITAL_LAUNCH_MOUNT_HEIGHT
  # Increment the number of engines until minimum viable thrust is reached
  while current_thrust < minimum_thrust
    current_engines += 1
    current_thrust = current_engines * minimum_thrust
  end
  
  # Calculate the fuel used by the engines
  fuel_flow_rate = current_engines * 150 # assume 150 gallons per minute per engine
  fuel_used = fuel_flow_rate / FUEL_EFFICIENCY
  fuel_gallons += fuel_used
  
  # Calculate the new rocket weight after using fuel
  current_weight = ROCKET_WEIGHT + fuel_gallons * FUEL_DENSITY + PAYLOAD_WEIGHT
  
  # Calculate the new height using the rocket equation
  delta_v = current_thrust / current_weight * FUEL_EFFICIENCY
  current_height += delta_v * FUEL_EFFICIENCY / 2 / GRAVITY_ACCELERATION
  
  puts "At #{current_engines} engines and #{fuel_gallons.round(2)} gallons of fuel, reached #{current_height.round(2)} feet of lift"
end

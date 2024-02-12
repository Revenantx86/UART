
message_a = r"""
      ____________________________
     /                           /\
    /           Works !        _/ /\
   /                          / \/
  /                           /\
 /___________________________/ /
 \___________________________\/
  \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 
  """

def read_data(file_path):
    data_values = []
    with open(file_path, 'r') as file:
        for line in file:
            line = line.strip()
            # Skip lines that cannot be directly converted to integers
            if line.isdigit():
                data_values.append(int(line))
            else:
                # For debugging: print out lines that are skipped
                print(f"Skipping line: {line}")
    return data_values

def verify_data(data_values):
    # Example verification: check if data_values are sequential
    errors = 0
    for expected_value, actual_value in enumerate(data_values, start=1): # Adjust based on expected start value
        if expected_value != actual_value:
            print(f"Data mismatch at position {expected_value}: expected {expected_value}, got {actual_value}")
            errors += 1
    if errors == 0:
        print(message_a)
    else:
        print(f"Total errors: {errors}")

if __name__ == "__main__":
    file_path = 'test/fifo/output_data.txt'  # Update to the path where your data file is saved
    data_values = read_data(file_path)
    verify_data(data_values)


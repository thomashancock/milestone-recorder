import os
import subprocess


def clean():
  os.remove("db/test.db")


def execute(command):
  args = ['stack', 'run']
  if command != "" and command != None:
    args = args + command.split()
  process = subprocess.Popen(args,
                      stdout=subprocess.PIPE, 
                      stderr=subprocess.PIPE)
  stdout, stderr = process.communicate()
  return stdout.decode('utf-8'), stderr.decode('utf-8')


def failed(name, expected, actual):
  return f"Test failed:\nExpected: {expected}\nActual: {actual}"


def runTest(name, command, expectedOut, expectedErr = ""):
  print(f"Running test: {name}. Command = {command}")
  stdout, stderr = execute(command)
  passed = True
  if stdout != expectedOut:
    passed = False
    print('\t' + failed(name, expectedOut, stdout))
  if stderr != expectedErr:
    passed = False
    print('\t' + failed(name, expectedErr, stderr))
  if passed:
    print("\t...passed")


def main():
  runTest("No args", "", "No args provided\n")

  def expect(*args):
    return "".join(args)

  # Test Add & Delete functionality
  clean()
  runTest('Add no args', 'Add', 'Add requested but no args provided\n')
  runTest('Add', 'Add 2021-1-2 "January Event"', 'Added 2021-1-2 "January Event"\n')
  runTest('Add', 'Add 2021-2-3 "February Event"', 'Added 2021-2-3 "February Event"\n')

  runTest('List added events', 'List', expect(
    '1: 2021-1-2 - "January Event"\n', 
    '2: 2021-2-3 - "February Event"\n'
    ))

  runTest('Delete', 'Delete 1', 'Deleted row with id 1\n')

  runTest('List post-deletion', 'List', expect(
    '2: 2021-2-3 - "February Event"\n'
    ))

  # Test List functionality
  clean()
  execute('Add 2021-1-2 "January Event"')
  execute('Add 2021-2-14 "February Event"')
  execute('Add 2021-3-25 "March Event"')

  janStr = '1: 2021-1-2 - "January Event"\n'
  febStr = '2: 2021-2-14 - "February Event"\n'
  marStr = '3: 2021-3-25 - "March Event"\n'

  runTest('List no args', 'List', expect(janStr, febStr, marStr))

  runTest('List before', 'List before 2021-2-1', expect(janStr))
  runTest('List before no entries', 'List before 2021-1-1', expect())

  runTest('List after', 'List after 2021-2-1', expect(febStr, marStr))
  runTest('List after', 'List after 2021-2-30', expect(marStr)) 
  runTest('List after no entries', 'List after 2021-4-1', expect())

  runTest('List range', 'List after 2021-1-13 before 2021-3-1', expect(febStr))
  runTest('List range args order swap', 'List before 2021-3-1 after 2021-1-13', expect(febStr))

  # Clean up after the tests
  clean()
  

if __name__ == "__main__":
  main()

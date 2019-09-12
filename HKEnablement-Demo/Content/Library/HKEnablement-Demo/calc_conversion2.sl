namespace: HKEnablement-Demo
operation:
  name: calc_conversion2
  inputs:
    - acres_input: '7'
  sequential_action:
    gav: 'com.microfocus.seq:HKEnablement-Demo.calc_conversion2:1.0.0'
    steps:
      - step:
          id: '1'
          object_path: 'Window("Calculator").WinMenu("Menu")'
          action: Select
          default_args: "\"View;Unit conversion\tCtrl+U\""
      - step:
          id: '3'
          object_path: 'Window("Calculator").WinComboBox("Select the type of unit")'
          action: Select
          default_args: '"Area"'
          snapshot: ".\\Snapshots\\ssf2.png"
          highlight_id: '722016'
      - step:
          id: '4'
          object_path: 'Window("Calculator").WinComboBox("ComboBox")'
          action: Select
          default_args: '"Square meters"'
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '656510'
      - step:
          id: '5'
          object_path: 'Window("Calculator").WinEdit("From")'
          action: Set
          default_args: '"7"'
          snapshot: ".\\Snapshots\\ssf4.png"
          highlight_id: '854158'
          args: 'Parameter("acres_input")'
      - step:
          id: '6'
          object_path: 'Window("Calculator").WinEdit("To")'
          action: SetSelection
          default_args: '0,13'
          snapshot: ".\\Snapshots\\ssf5.png"
          highlight_id: '2754186'
      - step:
          id: '7'
          object_path: 'Window("Calculator").WinEdit("To")'
          action: Output
          default_args: 'CheckPoint("param")'
          args: 'CheckPoint("param")'
      - step:
          id: '8'
          object_path: 'Window("Calculator")'
          action: Close
  outputs:
    - param:
        robot: true
        value: '${param}'
    - return_result: '${return_result}'
    - error_message: '${error_message}'
  results:
    - SUCCESS
    - WARNING
    - FAILURE

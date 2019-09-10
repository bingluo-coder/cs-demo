namespace: HKEnablement-Demo
operation:
  name: calc_conversion
  inputs:
    - acres_input
  sequential_action:
    gav: 'com.microfocus.seq:HKEnablement-Demo.calc_conversion:1.0.0'
    steps:
      - step:
          id: '1'
          object_path: 'Window("Calculator").WinMenu("Menu")'
          action: Select
          default_args: "\"View;Unit conversion\tCtrl+U\""
      - step:
          id: '2'
          object_path: 'Window("Calculator").WinComboBox("Select the type of unit")'
          action: Select
          default_args: '"Area"'
          snapshot: ".\\Snapshots\\ssf1.png"
          highlight_id: '2361172'
      - step:
          id: '3'
          object_path: 'Window("Calculator").WinEdit("From")'
          action: Set
          default_args: '"100"'
          snapshot: ".\\Snapshots\\ssf2.png"
          highlight_id: '462382'
          args: 'Parameter("acres_input")'
      - step:
          id: '4'
          object_path: 'Window("Calculator").WinComboBox("To")'
          action: Select
          default_args: '"Square meters"'
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '200320'
      - step:
          id: '5'
          object_path: 'Window("Calculator").WinEdit("To")'
          action: SetCaretPos
          default_args: '11'
          snapshot: ".\\Snapshots\\ssf4.png"
          highlight_id: '331356'
      - step:
          id: '6'
          object_path: 'Window("Calculator").WinEdit("To")'
          action: SetSelection
          default_args: '3,12'
          snapshot: ".\\Snapshots\\ssf5.png"
          highlight_id: '331356'
      - step:
          id: '7'
          object_path: 'Window("Calculator").WinEdit("To")'
          action: SetSelection
          default_args: '5,12'
          snapshot: ".\\Snapshots\\ssf6.png"
          highlight_id: '331356'
      - step:
          id: '8'
          object_path: 'Window("Calculator").WinEdit("To")'
          action: SetSelection
          default_args: '0,12'
          snapshot: ".\\Snapshots\\ssf7.png"
          highlight_id: '331356'
      - step:
          id: '9'
          object_path: 'Window("Calculator").WinEdit("To")'
          action: Output
          default_args: 'CheckPoint("square_meters_output")'
  outputs:
    - square_meters_output:
        robot: true
        value: '${square_meters_output}'
    - return_result: '${return_result}'
    - error_message: '${error_message}'
  results:
    - SUCCESS
    - WARNING
    - FAILURE

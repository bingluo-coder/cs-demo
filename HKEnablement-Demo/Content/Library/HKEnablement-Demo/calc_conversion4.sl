namespace: HKEnablement-Demo
operation:
  name: calc_conversion4
  outputs:
  - days_difference:
      robot: true
      value: ${days_difference}
  - return_result: ${return_result}
  - error_message: ${error_message}
  sequential_action:
    gav: com.microfocus.seq:HKEnablement-Demo.calc_conversion4:1.0.0
    steps:
    - step:
        id: '1'
        object_path: Window("Calculator")
        action: Move
        default_args: 1218,345
        snapshot: .\Snapshots\ssf1.png
        highlight_id: '2295126'
    - step:
        id: '2'
        object_path: Window("Calculator").WinMenu("Menu")
        action: Select
        default_args: "\"View;Date calculation\tCtrl+E\""
    - step:
        id: '3'
        object_path: Window("Calculator").WinCalendar("From")
        action: SetDate
        default_args: '"8-May-2019"'
        snapshot: .\Snapshots\ssf2.png
        highlight_id: '4654388'
    - step:
        id: '4'
        object_path: Window("Calculator").WinButton("Calculate")
        action: Click
        snapshot: .\Snapshots\ssf3.png
        highlight_id: '3933364'
    - step:
        id: '5'
        object_path: Window("Calculator").WinEdit("Difference (days)")
        action: SetSelection
        default_args: 0,8
        snapshot: .\Snapshots\ssf4.png
        highlight_id: '3736566'
    - step:
        id: '6'
        object_path: Window("Calculator").WinEdit("Difference (days)")
        action: Output
        default_args: CheckPoint("days_difference")
    - step:
        id: '7'
        object_path: Window("Calculator")
        action: Close
  results:
  - SUCCESS
  - WARNING
  - FAILURE

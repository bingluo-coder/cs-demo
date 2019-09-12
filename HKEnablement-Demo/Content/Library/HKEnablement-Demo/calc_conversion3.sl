namespace: HKEnablement-Demo
operation:
  name: calc_conversion3
  outputs:
  - difference_days:
      robot: true
      value: ${difference_days}
  - return_result: ${return_result}
  - error_message: ${error_message}
  sequential_action:
    gav: com.microfocus.seq:HKEnablement-Demo.calc_conversion3:1.0.0
    steps:
    - step:
        id: '1'
        object_path: Window("Calculator").WinMenu("Menu")
        action: Select
        default_args: "\"View;Date calculation\tCtrl+E\""
    - step:
        id: '2'
        object_path: Window("Calculator").WinCalendar("From")
        action: SetDate
        default_args: '"9-Jul-2019"'
        snapshot: .\Snapshots\ssf1.png
        highlight_id: '198186'
    - step:
        id: '3'
        object_path: Window("Calculator").WinEdit("Difference (years, months,")
        action: SetCaretPos
        default_args: '0'
        snapshot: .\Snapshots\ssf2.png
        highlight_id: '198194'
    - step:
        id: '4'
        object_path: Window("Calculator").WinButton("Calculate")
        action: Click
        snapshot: .\Snapshots\ssf3.png
        highlight_id: '198164'
    - step:
        id: '5'
        object_path: Window("Calculator").WinEdit("Difference (days)")
        action: SetSelection
        default_args: 0,7
        snapshot: .\Snapshots\ssf4.png
        highlight_id: '263698'
    - step:
        id: '6'
        object_path: Window("Calculator").WinEdit("Difference (days)")
        action: Output
        default_args: CheckPoint("difference_days")
    - step:
        id: '7'
        object_path: Window("Calculator")
        action: Close
  results:
  - SUCCESS
  - WARNING
  - FAILURE

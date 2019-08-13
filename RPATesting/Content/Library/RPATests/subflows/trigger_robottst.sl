########################################################################################################################
#!!
#! @description: This flow triggers an RPA Robot (UFT Scenario). 
#!               The UFT Scenario needs to exist before this flow is ran.
#!
#! @input host: The host where UFT and robots (UFT scenarios) are located.
#! @input port: The WinRM port of the provided host. Default: https: 5986 http: 5985
#! @input protocol: The WinRM protocol.
#! @input username: The username for the WinRM connection.
#! @input password: The password for the WinRM connection.
#! @input is_robot_visible: Parameter to set if the Robot actions should be visible in the UI or not.
#! @input robot_path: The path to the robot(UFT scenario).
#! @input robot_results_path: The path where the robot(UFT scenario) will save its results.
#! @input robot_parameters: Robot parameters from the UFT scenario. A list of name:value pairs separated by comma. Eg. name1:value1,name2:value2
#! @input rpa_workspace_path: The path where the OO will create needed scripts for robot execution.
#!!#
########################################################################################################################
namespace: RPATests.subflows
flow:
  name: trigger_robottst
  inputs:
    - host
    - port:
        required: false
    - protocol:
        required: false
    - username:
        required: false
    - password:
        required: false
    - proxy_host:
        required: false
    - proxy_port:
        required: false
    - proxy_username:
        required: false
    - proxy_password:
        required: false
    - is_robot_visible: 'True'
    - robot_path
    - robot_results_path
    - robot_parameters
    - rpa_workspace_path
  workflow:
    - create_trigger_robot_vb_script:
        do:
          utility.create_trigger_robot_vb_script:
            - host: '${host}'
            - port: '${port}'
            - protocol: '${protocol}'
            - username: '${username}'
            - password: '${password}'
            - proxy_host: '${proxy_host}'
            - proxy_port: '${proxy_port}'
            - proxy_username: '${proxy_username}'
            - proxy_password: '${proxy_password}'
            - is_robot_visible: '${is_robot_visible}'
            - robot_path: '${robot_path}'
            - robot_results_path: '${robot_results_path}'
            - robot_parameters: '${robot_parameters}'
            - rpa_workspace_path: '${rpa_workspace_path}'
        publish:
          - script_name
        navigate:
          - FAILURE: on_failure
          - SUCCESS: trigger_vb_script
    - trigger_vb_script:
        do:
          io.cloudslang.base.powershell.powershell_script:
            - host: '${host}'
            - port: '${port}'
            - protocol: '${protocol}'
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
            - proxy_host: '${proxy_host}'
            - proxy_port: '${proxy_port}'
            - proxy_username: '${proxy_username}'
            - proxy_password:
                value: '${proxy_password}'
                sensitive: true
            - script: "${'invoke-expression \"cmd /C cscript ' + script_name + '\"'}"
            - operation_timeout: '180'
        publish:
          - exception
          - return_code
          - stderr
          - script_exit_code
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: delete_vb_script_1
    - delete_vb_script_1:
        do:
          io.cloudslang.base.powershell.powershell_script:
            - host: '${host}'
            - port: '${port}'
            - protocol: '${protocol}'
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
            - proxy_host: '${proxy_host}'
            - proxy_port: '${proxy_port}'
            - proxy_username: '${proxy_username}'
            - proxy_password:
                value: '${proxy_password}'
                sensitive: true
            - script: "${'Remove-Item \"' + script_name + '\"'}"
        publish:
          - exception
          - return_code
          - stderr
          - script_exit_code
        navigate:
          - SUCCESS: FAILURE
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      create_trigger_robot_vb_script:
        x: 53
        'y': 79
      trigger_vb_script:
        x: 344
        'y': 76
        navigate:
          5293e98c-9837-4a9c-5837-1f7938b48b31:
            targetId: 023c90fc-05ed-adf3-eb3c-da02c1f4333a
            port: SUCCESS
      delete_vb_script_1:
        x: 585
        'y': 242
        navigate:
          6585b707-8ed3-ad4a-4c92-06a5c32e5b7a:
            targetId: 9075912d-0472-2f13-bd04-f716ea7744ed
            port: SUCCESS
    results:
      FAILURE:
        9075912d-0472-2f13-bd04-f716ea7744ed:
          x: 823
          'y': 231
      SUCCESS:
        023c90fc-05ed-adf3-eb3c-da02c1f4333a:
          x: 824
          'y': 83

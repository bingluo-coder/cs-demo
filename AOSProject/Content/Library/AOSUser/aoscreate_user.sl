namespace: AOSUser
flow:
  name: aoscreate_user
  inputs:
    - usern: nttuser
    - firstn: nttuser
    - lastn: user
    - emailn: ntt@ntt.com
    - phonum: '8187150548'
  workflow:
    - trigger_robot:
        do:
          uft.trigger_robot:
            - host: 10.3.163.91
            - port: '5985'
            - protocol: http
            - username: administrator
            - password: Police123
            - is_robot_visible: 'False'
            - robot_path: "C:\\Users\\shoaibh\\Documents\\Unified Functional Testing\\GUITest8"
            - robot_results_path: "C:\\Users\\shoaibh\\Documents\\Unified Functional Testing\\GUITest8\\OOresults"
            - robot_parameters: "${'username:'+usern+',firstname:'+firstn+',lastname:'+lastn+',email:'+emailn+',phnum:'+phonum}"
            - rpa_workspace_path: "C:\\Users\\shoaibh\\Documents\\OOExecution"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: send_mail
    - send_mail:
        do:
          io.cloudslang.base.mail.send_mail:
            - hostname: smtp.hpintelco.org
            - port: '25'
            - from: hcm@hpecic.net
            - to: shoaib.meh.ali@microfocus.com
            - subject: AOS User Created
            - body: "${'AOS user with username '+usern+' is created. You can login to AOS via http://chatops.helion1.hpintelco.org:18000. The password to your user is Test1.'}"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      trigger_robot:
        x: 223
        y: 191
      send_mail:
        x: 407
        y: 193
        navigate:
          2f2b6d8b-72f6-624d-deab-31780824f94f:
            targetId: 9aada4ad-6a94-8adc-2725-8ed136a10cea
            port: SUCCESS
    results:
      SUCCESS:
        9aada4ad-6a94-8adc-2725-8ed136a10cea:
          x: 616
          y: 197

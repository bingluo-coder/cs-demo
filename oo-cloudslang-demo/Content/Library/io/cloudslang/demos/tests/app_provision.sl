namespace: io.cloudslang.demos.tests
flow:
  name: app_provision
  workflow:
    - deploy_instance:
        do:
          io.cloudslang.demos.amazon.deploy_instance:
            - identity: "${get_sp('amazon.identity')}"
            - credential:
                value: "${get_sp('amazon.credential')}"
                sensitive: true
            - image_id: "${get_sp('amazon.image_id')}"
            - instance_type: "${get_sp('amazon.instance_type')}"
        publish:
          - instance_id
          - ip_address
        navigate:
          - SUCCESS: post_message
          - FAILURE: create_incident
    - post_message:
        do:
          io.cloudslang.demos.slack.chat.post_message:
            - text: "${'Your EC2 Instance is ready: '+instance_id+'. Your application is accessible here http://'+ip_address}"
        navigate:
          - FAILURE: create_incident
          - SUCCESS: password
    - create_change:
        do:
          io.cloudslang.demos.servicenow.create_change:
            - description: "${'Reset my temporary password with: '+password}"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: create_incident
    - password:
        do:
          io.cloudslang.demos.utils.password: []
        publish:
          - password: '${return_result}'
        navigate:
          - SUCCESS: create_change
    - create_incident:
        do:
          io.cloudslang.demos.servicenow.create_incident:
            - description: Create Incident for AWS
        navigate:
          - SUCCESS: FAILURE
          - FAILURE: FAILURE
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      deploy_instance:
        x: 41
        y: 192
      post_message:
        x: 243
        y: 189
      create_change:
        x: 753
        y: 206
        navigate:
          534d3e75-3766-ccb1-8245-ff7e755da710:
            targetId: ecbbbc73-c78a-d390-e8b2-3de768cc8db7
            port: SUCCESS
      password:
        x: 470
        y: 196
      create_incident:
        x: 475
        y: 417
        navigate:
          79d9760f-9fd3-f224-cd9e-ccbebefc2d48:
            targetId: f83e1260-4b16-9d29-baa3-544296aeebe2
            port: SUCCESS
          7b42a84c-09e8-b9f5-9437-a70bf8407f28:
            targetId: f83e1260-4b16-9d29-baa3-544296aeebe2
            port: FAILURE
    results:
      SUCCESS:
        ecbbbc73-c78a-d390-e8b2-3de768cc8db7:
          x: 1211
          y: 196
      FAILURE:
        f83e1260-4b16-9d29-baa3-544296aeebe2:
          x: 637
          y: 561

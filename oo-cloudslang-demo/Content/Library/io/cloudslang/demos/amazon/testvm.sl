namespace: io.cloudslang.demos.amazon
flow:
  name: testvm
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
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      deploy_instance:
        x: 196
        y: 71
        navigate:
          9ba786e6-7621-3614-7f11-94679ab23fd3:
            targetId: 38653554-ba5b-2bbc-d697-dfb217091efd
            port: SUCCESS
    results:
      SUCCESS:
        38653554-ba5b-2bbc-d697-dfb217091efd:
          x: 422
          y: 70

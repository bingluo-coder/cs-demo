namespace: io.cloudslang.demos.utils
flow:
  name: get_epoch_time
  workflow:
    - get_time:
        do:
          io.cloudslang.base.datetime.get_time:
            - locale_lang: unix
        publish:
          - epoch: '${output}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - epoch: '${epoch}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_time:
        x: 100
        y: 150
        navigate:
          73309cdf-2e92-b176-c243-287d1ff8b58a:
            targetId: a565988b-e947-c3c3-f5bf-bb73245675aa
            port: SUCCESS
    results:
      SUCCESS:
        a565988b-e947-c3c3-f5bf-bb73245675aa:
          x: 400
          y: 150

########################################################################################################################
#!!
#! @input user: the user for which to generate a temporary key
#!!#
########################################################################################################################
namespace: io.cloudslang.demos.security
flow:
  name: add_generated_key_pair_to_vault
  inputs:
    - user: hcm_user
  workflow:
    - generate_key_pair:
        do:
          io.cloudslang.demos.security.generate_key_pair: []
        publish:
          - private_key
        navigate:
          - SUCCESS: url_encoder
          - FAILURE: on_failure
    - add_secret:
        do:
          io.cloudslang.demos.security.vault.add_secret:
            - secret: '${user}'
            - secret_value: '${private_key}'
        publish: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: read_secret
    - url_encoder:
        do:
          io.cloudslang.base.http.url_encoder:
            - data: '${user}'
        publish:
          - user: '${result}'
        navigate:
          - SUCCESS: add_secret
          - FAILURE: on_failure
    - read_secret:
        do:
          io.cloudslang.demos.security.vault.read_secret:
            - secret: '${user}'
        publish: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      generate_key_pair:
        x: 88
        y: 102
      add_secret:
        x: 266
        y: 102
      url_encoder:
        x: 191
        y: 261
      read_secret:
        x: 383
        y: 253
        navigate:
          43e66e2f-be31-f986-e9ca-78b077251e16:
            targetId: 8cc58fdc-3f6d-00d5-479d-b8c9a0bd4835
            port: SUCCESS
    results:
      SUCCESS:
        8cc58fdc-3f6d-00d5-479d-b8c9a0bd4835:
          x: 462
          y: 107

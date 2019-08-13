########################################################################################################################
#!!
#! @description: generates a random and timestamp based key and adds it to a vault server while handing over the private key to the user over a slack channel.
#!
#! @input user: The user for which the key will be generated
#!!#
########################################################################################################################
namespace: io.cloudslang.demos.security
flow:
  name: generate_key_and_notify
  inputs:
    - user: hcm_user
  workflow:
    - generate_key_pair:
        do:
          io.cloudslang.demos.security.generate_key_pair: []
        publish:
          - private_key
        navigate:
          - SUCCESS: encode_username
          - FAILURE: on_failure
    - add_secret_to_vault:
        do:
          io.cloudslang.demos.security.vault.add_secret:
            - secret: '${user}'
            - secret_value: '${private_key}'
        publish: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - encode_username:
        do:
          io.cloudslang.base.http.url_encoder:
            - data: '${user}'
        publish:
          - user: '${result}'
        navigate:
          - SUCCESS: add_secret_to_vault
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      generate_key_pair:
        x: 81
        y: 95
      add_secret_to_vault:
        x: 328
        y: 96
        navigate:
          5c1ef1f9-f0c7-727c-bbd5-d1a9830b5001:
            targetId: 8cc58fdc-3f6d-00d5-479d-b8c9a0bd4835
            port: SUCCESS
      encode_username:
        x: 191
        y: 261
    results:
      SUCCESS:
        8cc58fdc-3f6d-00d5-479d-b8c9a0bd4835:
          x: 790
          y: 92

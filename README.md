# Agent Morpheus Self hosted Models.

This repo contains umbrella helm chart to install embedding model nim-embed for creating embeddings to store in VDB and one of the
following LLM:

1. llama3.1-70b-instruct-4bit
2. nim llama3.1-8b-instruct(16 bit quantization).

## Deploying the chart

1. Type in your NGC_API_KEY ( get one [here](https://docs.nvidia.com/ngc/gpu-cloud/ngc-user-guide/index.html#generating-api-key))
```shell
export NGC_API_KEY=your_api_key_goes_here
```

2. Replace placeholder password with your real API Key
```shell
sed -E 's/ \&ngc-api-key changeme/ \&ngc-api-key '$NGC_API_KEY'/' values.yaml  > agent-morpheus-models/yourenv_values.yaml
```

3. Deploy the chart
```shell
 helm install agent-morpheus-models agent-morpheus-models/ -f agent-morpheus-models/yourenv_values.yaml
```
Output:
```shell
NAME: agent-morpheus-models
LAST DEPLOYED: Sun Dec  8 23:05:14 2024
NAMESPACE: test-models
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Send a prompt to the model to test it works:
oc wait --for=condition=ready pod -l component=llama3.1-70b-instruct  --timeout 1000s
curl -X POST -H "Content-Type: application/json" http://llama3-1-70b-instruct-4bit-test-models.apps.ai-dev03.kni.syseng.devcluster.openshift.com/v1/chat/completions -d @$(git rev-parse --show-toplevel)/agent-morpheus-models/files/70b-4bit-input-example.json | jq .
```

4. Wait for LLM pod to be ready, and then send an example request to the LLM, in order to get output
```shell
oc wait --for=condition=ready pod -l component=llama3.1-70b-instruct  --timeout 1000s
curl -X POST -H "Content-Type: application/json" http://llama3-1-70b-instruct-4bit-test-models.apps.ai-dev03.kni.syseng.devcluster.openshift.com/v1/chat/completions -d @$(git rev-parse --show-toplevel)/agent-morpheus-models/files/70b-4bit-input-example.json | jq .
```

5. Whenever finishing with models , and wants to free up resources,  you can delete the chart
```shell
helm uninstall agent-morpheus-models
```

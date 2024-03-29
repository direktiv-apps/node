
# node 1.0

Run node in Direktiv

---
- #### Categories: build, development
- #### Image: gcr.io/direktiv/functions/node 
- #### License: [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)
- #### Issue Tracking: https://github.com/direktiv-apps/node/issues
- #### URL: https://github.com/direktiv-apps/node
- #### Maintainer: [direktiv.io](https://www.direktiv.io) 
---

## About node

This function provides a Node.js a s a Direktiv function. Node Version Manager is installed to support LTS versions. The following versions are installed in this function:

- 18.10.0

- 16.17.1

NVM (Node Version Manager) can be used as well to install different versions but it is function wide which means changes are visible to all function calls during the function / container lifetime. If the application is returning plain JSON on standard out it will be used as JSON result in Direktiv. If the application prints other strings to standard out the response will be a plain string. If JSON output is required the application can create and write to a file called output.json. If this file exists, this function uses its contents as return value.
Functions can have a context to persist the node_modules directory across different execution cycles. Unlike Direktiv's regular behaviour to have a new working directory for each execution, the context ensures that it runs in the same directory each time. 

### Example(s)
  #### Function Configuration
```yaml
functions:
- id: node
  image: gcr.io/direktiv/functions/node:1.0
  type: knative-workflow
```
   #### Basic
```yaml
- id: node 
  type: action
  action:
    function: node
    input:
      files:
      - name: hello.js
        data: |
          console.log("Hello World"); 
      commands:
      - command: node hello.js
```
   #### Change node version
```yaml
- id: node 
  type: action
  action:
    function: node
    input:
      node: "16"
      commands:
      - command: node -v
```
   #### Using a context
```yaml
- id: node 
  type: action
  action:
    function: node
    input: 
      context: uuid-app
      files: 
      - name: myapp.js
        data: |
          const { v4: uuidv4 } = require('uuid');
          console.log(uuidv4());
      commands:
      - command: npm install uuid
      - command: node myapp.js   
```
   #### Using Direktiv variable as script
```yaml
- id: node 
  type: action
  action:
    function: node
    files:
    - key: out.js
      scope: workflow
    input:
      commands:
      - command: node out.js      
```

   ### Secrets


*No secrets required*







### Request



#### Request Attributes
[PostParamsBody](#post-params-body)

### Response
  List of executed commands.
#### Reponse Types
    
  

[PostOKBody](#post-o-k-body)
#### Example Reponses
    
```json
[
  {
    "result": "Hello World",
    "success": true
  }
]
```

### Errors
| Type | Description
|------|---------|
| io.direktiv.command.error | Command execution failed |
| io.direktiv.output.error | Template error for output generation of the service |
| io.direktiv.ri.error | Can not create information object from request |


### Types
#### <span id="post-o-k-body"></span> postOKBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| node | [][PostOKBodyNodeItems](#post-o-k-body-node-items)| `[]*PostOKBodyNodeItems` |  | |  |  |


#### <span id="post-o-k-body-node-items"></span> postOKBodyNodeItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| result | [interface{}](#interface)| `interface{}` | ✓ | |  |  |
| success | boolean| `bool` | ✓ | |  |  |


#### <span id="post-params-body"></span> postParamsBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| commands | [][PostParamsBodyCommandsItems](#post-params-body-commands-items)| `[]*PostParamsBodyCommandsItems` |  | `[{"command":"node app.js"}]`| Array of commands. |  |
| context | string| `string` |  | | Direktiv will delete the working directory after each execution. With the context the application can run in a different
directory and commands like npm install will be persistent. If context is not set the "node_module" directory will be deleted
and each execution of the flow uses an empty modules folder. Multiple apps can not share a context. |  |
| files | [][DirektivFile](#direktiv-file)| `[]apps.DirektivFile` |  | | File to create before running commands. |  |
| node | string| `string` |  | `"18.10.0"`| Default node version for the script |  |


#### <span id="post-params-body-commands-items"></span> postParamsBodyCommandsItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| command | string| `string` |  | | Command to run |  |
| continue | boolean| `bool` |  | | Stops excecution if command fails, otherwise proceeds with next command |  |
| envs | [][PostParamsBodyCommandsItemsEnvsItems](#post-params-body-commands-items-envs-items)| `[]*PostParamsBodyCommandsItemsEnvsItems` |  | | Environment variables set for each command. | `[{"name":"MYVALUE","value":"hello"}]` |
| print | boolean| `bool` |  | `true`| If set to false the command will not print the full command with arguments to logs. |  |
| silent | boolean| `bool` |  | | If set to false the command will not print output to logs. |  |


#### <span id="post-params-body-commands-items-envs-items"></span> postParamsBodyCommandsItemsEnvsItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| name | string| `string` |  | | Name of the variable. |  |
| value | string| `string` |  | | Value of the variable. |  |

 

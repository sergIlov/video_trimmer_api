### Backend server that provides an API for trimming video

User uploads video and defines timing parameters: start time, end time. After that video will be trimmed using that timing.
User can trim one video as many times as he wants. 

### REST API reference

#### Authentication

All request (except `Create user token`) must be authenticated with HTTP Token, which can be gotten by calling 
`Create user token`  
___

#### Create user token
**POST** `/v1/users`

**Response:**

 ```
 { 
   token: 'user token'  
 }
 ```
___

#### Original videos list

**GET** `/v1/videos`

**Response:**  

```
[
  { 
    id: 'video id',  
    url: 'link to original video'
    created_at: 'create time'
  },
  ...
 ]
```

#### Upload video
**POST** `/v1/videos`

**Parameters:**

| Name      | Type          | Description     |
| --------- |:-------------:| ---------------:|
| file      | file          | file to upload  | 

**Response:**

 ```
 { 
   id: 'video id',  
   url: 'link to original video'
   created_at: 'create time'
 }
 ```

#### Show video
**GET** `/v1/videos/:video_id`

**Response:**

 ```
 { 
   id: 'video id',  
   url: 'link to original video'
   created_at: 'create time'
 }
 ```
___
 
#### Show tasks list
  
**GET** `/v1/tasks`

**Response:**  

```
[
  { 
    id: 'video id',  
    created_at: 'create time'
    url: 'url to trimmed video'
    duration: 'trimmed video duration'
    state: 'task state'
  },
  ...
 ]
```

#### Create task
**POST** `/v1/tasks`

**Parameters:**

| Name          | Type                | Description         |
| ------------- |:-------------------:| -------------------:|
| video_id      | string              | original video id   |
| start_time    | integer _(optional)_| start time          |
| end_time      | integer             | end time            |

**Response:**

```
{ 
  id: 'video id',  
  created_at: 'create time'
  url: 'url to trimmed video'
  duration: 'trimmed video duration'
  state: 'task state'
}
```
 
 #### Show task
 **GET** `/v1/tasks/:task_id`
 
 **Response:**
 
```
{ 
  id: 'video id',  
  created_at: 'create time'
  url: 'url to trimmed video'
  duration: 'trimmed video duration'
  state: 'task state'
}
```

#### Reschedule failed task
**GET** `/v1/tasks/:task_id/restart`
 
**Response:**
 
```
{ 
  id: 'video id',  
  created_at: 'create time'
  url: 'url to trimmed video'
  duration: 'trimmed video duration'
  state: 'task state'
}
```

#### Task states

+ new
+ scheduled
+ processing
+ failed
+ done




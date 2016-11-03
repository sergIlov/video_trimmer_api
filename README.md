### Backend server that provides an API for trimming video

User uploads video and defines timing parameters: start time, end time. After that video will be trimmed using that timing.
User can trim one video as many times as he wants. 

### REST API reference

#### Original videos list

**GET** `/v1/videos`

**Response:**  

```json
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

 ```json
 { 
   id: 'video id',  
   url: 'link to original video'
   created_at: 'create time'
 }
 ```

#### Show video
**GET** `/v1/videos/:video_id`

**Response:**

 ```json
 { 
   id: 'video id',  
   url: 'link to original video'
   created_at: 'create time'
 }
 ```




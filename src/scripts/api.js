import axios from 'axios'

export default function flickr(method, params) {
  return axios({
    method: 'get',
    url: 'https://api.flickr.com/services/rest',
    params: {
      api_key: '370194a0185ccc57c899cf3fbc5e70c1',
      format: 'json',
      nojsoncallback: 1,
      ...params,
      method: `flickr.${method}`,
    }
  })
}

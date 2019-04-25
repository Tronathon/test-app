import Vue from 'vue';
import axios from 'axios';
import Home from './components/Home';
import Entry from './components/Entry';

var app = new Vue({
    el: '#app',
    data () {
        return info
    },
    components: {
		Home,
        Entry
	},
	created () {
		let url = 'https://api.nasa.gov/neo/rest/v1/neo/browse?api_key=XazQc7UyC2JxBbz9bcED1D7LMa4i8Q9pRQHTbOA3'
		axios.get(url)
		.then(function(response){
			console.log(response.data)
		})
	}
});

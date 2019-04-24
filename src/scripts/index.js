import Vue from 'vue';
import Home from './components/Home';
import Entry from './components/Entry';

var app = new Vue({
    el: '#app',
    data: {
        message: 'Hello Vue!'
    },
    components: {
		Home,
        Entry
    }
});


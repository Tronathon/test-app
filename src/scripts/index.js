import Vue from 'vue';
import Overview from './components/Overview';
import {router} from './routes.js';


Vue.config.productionTip = true;

new Vue({
	render: h => h(Overview),
	router

}).$mount('#app');



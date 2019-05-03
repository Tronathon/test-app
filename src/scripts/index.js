import Vue from 'vue';
import Overview from './components/Overview';
import routes from './routes.js';


Vue.config.productionTip = true;

new Vue({
	render: h => h(Overview),
	router: routes

}).$mount('#app');



import Vue from 'vue';
import Home from './components/Home';

Vue.config.productionTip = true;

new Vue({
  render: h => h(Home),
}).$mount('#app');

// var app = new Vue({
// 	el: '#app',
// 	props: ['image'],
// 	components: {
// 		Home
// 	},
// 	data () {
// 		return {
// 			image

// 		}

// 	}
// })


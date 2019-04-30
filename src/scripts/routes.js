import Vue from 'vue';
import VueRouter from 'vue-router';
import Home from './components/Home';
import Detail from './components/Detail';

Vue.use(VueRouter);

export const router = new VueRouter({
		routes: [
			{ path: '/', component: Home, name: 'home' },
			{ path: '/photo/:id', component: Detail, name: 'photo' }
		]
	});

import Vue from 'vue';
import Router from 'vue-router';
import Home from './components/Home';
import SearchResults from './components/SearchResults';
import Detail from './components/Detail';

Vue.use(Router);

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
		},
		{
      path: '/image/:id',
      name: 'image',
			component: Detail,
			props: true,
    },
    {
      path: '/search/:tag',
      name: 'searchResults',
      component: SearchResults,
      props: true,
    },
  ],
});

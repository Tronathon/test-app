import Vue from 'vue';
import Router from 'vue-router';
import Home from './components/Home';
import SearchResults from './components/SearchResults';

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
      path: '/search/:tag',
      name: 'searchResults',
      component: SearchResults,
      props: true,
    },
  ],
});

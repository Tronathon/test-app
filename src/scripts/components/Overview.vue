<template>
	<div>
			<NavBar></NavBar>
			<router-view></router-view>
	</div>
</template>

<script>
import NavBar from './NavBar';

export default {
	name: 'Overview',
	components: {
		NavBar
	}
}
</script>


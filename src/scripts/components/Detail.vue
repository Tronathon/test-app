<template>
	<div>
		<img class="image-card__image" :src="image.url_n" :alt="image.title">
		<div class="image-card__body">
			<p v-if="image.title" class="image-title">{{image.title}}</p>
			<p v-else class="image-title">No Title Found</p>
			<p class="image-owner">By {{image.ownername}}</p>
			<section class="image-date-view-wrapper">
				<p class="image-date">{{image.datetaken}}</p>
				<p class="image-views">Views: {{image.views}}</p>
			</section>
		</div>
  	</div>
</template>

<script>

export default {
	name: 'Detail',
	data: {
			image: []
		}
}

</script>

<style>

</style>

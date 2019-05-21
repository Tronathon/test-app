<template>

	<router-link :to="{name: 'image', params: {id: image.id}}" class="image-card">

		<li>
			<img
				class="image-card__image"
				:class="{ skeleton: loading}"
				:src="imageUrl"
				:alt="title">
			<div class="image-card__body">
				<p class="image-title" :class="{skeleton: loading}">{{ title }}</p>
				<p class="image-owner" :class="{skeleton: loading}">{{ byline }}</p>
				<section class="image-date-view-wrapper">
					<p class="image-views" :class="{skeleton: loading}">Views: {{ viewCount }}</p>
				</section>
			</div>
		</li>

	</router-link>

</template>

<script>
const TRANSPARENT_GIF = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'

	export default {
		name: 'Entry',
		props: {
			image: {
				type: Object,
				default() {
					return {}
				}
			},
			loading: {
				type: Boolean,
				default: false,
		}
	},
	computed: {
    imageUrl() {
      if (this.loading) return TRANSPARENT_GIF
      return this.image.url_n
    },
    title() {
      return this.image.title || 'Untitled Image'
    },
    byline() {
      return `By ${this.image.ownername}`
    },
    viewCount() {
      const viewOrViews = this.image.views === 1 ? 'view' : 'views'
      return `${this.image.views} ${viewOrViews}`
    }
  }
	}
</script>

<style lang="scss">
.image-card {
  width: calc(33% - 1rem);
  margin: .5rem;
  border-radius: 5px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, .15);
  background: white;
  @media only screen and (max-width: 799px) {
    width: calc(50% - 1rem);
  }
  @media only screen and (max-width: 549px) {
    width: 100%;
    margin: .5rem 0;
  }
}
.image-card__image {
  border-radius: 5px 5px 0 0;
  width: 100%;
  height: 200px;
  object-fit: cover;
}
.image-card__body {
  padding: .5rem 1rem 1rem;
}
.image-title {
  font-weight: bold;
  margin: 0;
}
.image-owner {
  margin-top: 0;
  font-size: .8rem;
}
.image-title,
.image-owner {
  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;
}
.image-date-view-wrapper {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.image-date,
.image-views {
  margin-bottom: 0;
  font-size: .8rem;
}
@keyframes skeleton-glow {
  from {
    border-color: rgba(206,217,224,.2);
    background: rgba(206,217,224,.2);
  }
  to {
    border-color: rgba(92,112,128,.2);
    background: rgba(92,112,128,.2);
  }
}
.skeleton {
  animation: skeleton-glow 1s linear infinite alternate;
  background-clip: border-box;
  background-clip: padding-box !important;
  background: rgba(206,217,224,.2) !important;
  border-color: rgba(206,217,224,.2) !important;
  border-radius: 2px;
  box-shadow: none !important;
  color: transparent !important;
  cursor: default;
  pointer-events: none;
  user-select: none;
}
</style>

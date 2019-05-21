<template>
  <div class="wrapper">
	<img class="photo" :src="imageUrl" alt="">
    <h1>{{ title }}</h1>
    <p>By {{ ownerName }}</p>
    <h2>Description</h2>
    <p>{{ description }}</p>
    <h2>
      Tags
    </h2>
    <ul v-if="tags.length" class="photo-tag-list">
      <li v-for="tag in tags" :key="tag.id">
        <router-link
          :to="{name: 'searchResults', params: { tag: tag._content }}"
          class="photo-tag">
          {{ tag._content }}
        </router-link>
      </li>
    </ul>
    <p v-else>No tags found.</p>
  </div>
</template>

<script>
import flickr from '../api.js'

export default {
  name: 'Detail',
  props: {
    id: String
  },
   created() {
	this.fetchData()
  },
  data() {
    return {
	  imageInfo: null,
	  imageUrl: null,
    }
  },
  computed: {
      title() {
        if (this.imageInfo) {
          return this.imageInfo.title._content || 'Untitled Image'
        }
        return ''
      },
      ownerName() {
        if (this.imageInfo) {
          return this.imageInfo.owner.username
        }
        return ''
      },
      description() {
        if (this.imageInfo) {
          return this.imageInfo.description._content || 'No description available.'
        }
        return ''
      },
      tags() {
        if (this.imageInfo) {
          return this.imageInfo.tags.tag
        }
        return []
      }
    },
  methods: {
	fetchData() {
      this.fetchImageInfo()
      this.fetchImageSizes()
    },
	fetchImageInfo() {
		flickr('photos.getInfo', { photo_id: this.id }).then(
		response => {
			this.imageInfo = response.data.photo
		}
		)
	},
	fetchImageSizes() {
		return flickr('photos.getSizes', { photo_id: this.id }).then(response => {
			let sizes = response.data.sizes.size
			this.imageUrl = sizes.filter(s => s.label === "Large")[0].source
		})
		}
	},
}
</script>

<style lang="scss">
.photo-tag-list {
  display: flex;
  align-items: center;
  justify-content: flex-start;
  list-style: none;
  padding: 0;
  flex-wrap: wrap;
  li {
    margin: .5rem 0;
  }
}
.photo-tag {
  padding: .35rem .5rem;
  border-radius: 3px;
  background: #42b983;
  color: white;
  font-weight: bold;
  text-transform: uppercase;
  font-size: .8rem;
  text-decoration: none;
  margin: .25rem;
}
</style>


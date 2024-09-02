# Vue HackerNews 2.0 Documentation

## Overview

The Vue HackerNews 2.0 application is an application that replicates the HackerNews website using Vue.js. It allows users to view and interact with news stories and comments, demonstrating various Vue.js features such as components, routing, and state management.

## Functionality

### Components

##### 1. `main.js`:
   - The application starts with the main.js file, where Vue is initialized.  
   - It imports necessary modules and components.  
   - Sets up the router using Vue Router for client-side navigation.  
   - Configures the store using Vuex for state management.  
   - Mounts the main application component (App.vue) to the DOM.  
   
##### 2. `App.vue`:
   - The main application component that sets up the overall layout.
   - Contains the header navigation (Top, New, Show, Ask, Jobs), which allows users to navigate between different sections.
   - Uses the <router-view> element to render the component corresponding to the current route.

##### 3. `views/ItemView.vue`:
   - Displays the details of a single story (or item).
   - Fetches and displays the full details of a selected story, such as the title, author, score, comments, and content.
   - Uses a route parameter (id) to identify which story to display.

##### 4. `views/UserView.vue`:
   - Displays the profile of a specific user.
   - Fetches and displays user information, including the user's name, created date, karma, and submitted stories.

        
### Vuex Store

#### 1. state  
   - Contains the state variables like newsList, currentNews, and comments.
      
#### 2.actions  
   - `FETCH_LIST_DATA:` For fetching lists of story IDs.
   - `FETCH_ITEM:` For fetching an individual story.
   - `FETCH_USER:` For fetching user profile data.
        
#### 3.mutations
   - `SET_ACTIVE_TYPE(state, { type }):` This mutation sets the current type of news stories that the user is viewing (e.g., "top", "new", "show", "ask", "job"). When a user navigates to a different news category, this mutation updates the activeType to reflect the current selection.
   - `SET_LIST(state, { type, ids }):` When a list of story IDs is fetched from the API for a specific category (type), such as "top", "new", "show", etc., this mutation stores that list in the state. Each type (e.g., "top", "new") will have its own list of story IDs.
   - `SET_ITEMS(state, { items }):` This mutation is responsible for caching individual news stories or items in the state. The items are stored in an object format where each item is keyed by its ID. 
   - `SET_USER(state, { user }):` When a user profile is fetched from the API, this mutation stores that profile in the state.

### Routes

The Vue HackerNews 2.0 project defines several routes to manage the different views in the application. These routes are configured in the src/router/index.js file using Vue Router. 

   `/top:` Displays the list of top stories.  
   `/new:` Displays the list of new stories.  
   `/show:` Displays the list of "Show HN" stories (user-submitted items).  
   `/ask:` Displays the list of "Ask HN" stories (discussion threads).  
   `/job:` Displays the list of job postings.  
   `/item/:id:` Displays the details of a specific news story or item, including comments.  
   `/user/:id:` Displays the profile of a specific user, including their submitted stories and comments.  

## Implementation Details

    Client-Side Routing
      Vue Router is used to manage client-side navigation:
        Routes are defined in the router/index.js file. Each route corresponds to a specific view (e.g., TopStories, NewStories, ItemView).
        Routes like /top, /new, /show, /ask, and /job are mapped to components that fetch and display the relevant stories.

    Data Fetching:
      The application fetches data from the HackerNews API using HTTP requests. The data includes:
        Lists of stories (Top, New, Show, Ask, Jobs).
        Individual story details.
        User profiles.
        API requests are made using the fetch function defined in api/index.js. This function uses the axios library to make GET requests to the HackerNews API.

    State Management with Vuex
        The state is defined in the store/index.js file.
        It holds the state of stories, users, and items fetched from the HackerNews API.
        Actions like FETCH_LIST_DATA, FETCH_USER, and FETCH_ITEM are defined to asynchronously fetch data from the API and commit mutations to update the state.
        Mutations like SET_ACTIVE_TYPE, SET_LIST, and SET_USER are used to directly modify the state in a reactive way.

        
    
## Code Example

Here’s a snippet from the `UserView.vue` file:

```
<template>
  <div class="user-view">
    <template v-if="user">
      <h1>User : {{ user.id }}</h1>
      <ul class="meta">
        <li><span class="label">Created:</span> {{ user.created | timeAgo }} ago</li>
        <li><span class="label">Karma:</span> {{ user.karma }}</li>
        <li v-if="user.about" v-html="user.about" class="about"></li>
      </ul>
      <p class="links">
        <a :href="'https://news.ycombinator.com/submitted?id=' + user.id">submissions</a> |
        <a :href="'https://news.ycombinator.com/threads?id=' + user.id">comments</a>
      </p>
    </template>
    <template v-else-if="user === false">
      <h1>User not found.</h1>
    </template>
  </div>
</template>

<script>

export default {
  name: 'user-view',

  computed: {
    user () {
      return this.$store.state.users[this.$route.params.id]
    }
  },

  asyncData ({ store, route: { params: { id }}}) {
    return store.dispatch('FETCH_USER', { id })
  },

  title () {
    return this.user
      ? this.user.id
      : 'User not found'
  }
}
</script>

<style lang="stylus">
.user-view
  background-color #fff
  box-sizing border-box
  padding 2em 3em
  h1
    margin 0
    font-size 1.5em
  .meta
    list-style-type none
    padding 0
  .label
    display inline-block
    min-width 4em
  .about
    margin 1em 0
  .links a
    text-decoration underline
</style>
```

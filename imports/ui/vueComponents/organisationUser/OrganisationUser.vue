<template lang="pug">
v-card.pa-3.my-2
  | {{email}}
</template>

<script lang="coffee">
export default
  props: ['organisationUser']
  computed:
    email: -> @organisationUser?.emails[0].address
</script>

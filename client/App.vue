<template>
  <div>
    <div v-if="!(allSubsReady)">Loading...</div>
    <div v-else>
      <p>Hello {{hello}},
        <br>The time is now: {{currentTime}}
      </p>
      <button @click="updateTime">Update Time</button>
      <hr>
      <p>Organisations list</p>
      <ul>
        <li v-for="o in OrganisationCursor">
          {{o.name}}  -  {{o._id}}
        </li>
      </ul>
      <button @click="insertOrganisation">Insert Organisation</button>
    </div>
  </div>
</template>

<script>
  import '/imports/collections/Time';
  import '/imports/collections/Organisation';

  export default {
    watch: {
      '$subReady' (value){
        console.log('in watcher')
        console.log(value);
      },
      '$subReady.subscription' (value) {
        console.log('in watcher 2')
        console.log(value)
      }
    },
    computed: {
      allSubsReady: function() {
        var i, key, len, subsReady, subscriptionKeys;
        subscriptionKeys = Object.keys(this.$subReady);
        subsReady = subscriptionKeys[0] != null;
        for (i = 0, len = subscriptionKeys.length; i < len; i++) {
          key = subscriptionKeys[i];
          subsReady = subsReady && this.$subReady[key];
        }
        return subsReady;
      }
    },
    data() {
      console.log('Sending non-Meteor data to Vue component');
      return {
        hello: 'World',
        settings: Meteor.settings.public,   // not Meteor reactive
      }
    },
    // Vue Methods
    methods: {
      updateTime() {
        console.log('Calling Meteor Method UpdateTime');
        Meteor.call('UpdateTime');          // not Meteor reactive
      },
      insertOrganisation () {
        Meteor.call('InsertOrganisation');
      }
    },
    // Meteor reactivity
    meteor: {
      $subscribe: {
        'Time': [],
        'Organisation': [],
        'OrganisationData' () {
          return [this.organisationIds]
        }
      },
      currentTime () {
        console.log('Calculating currentTime');
        var t = Time.findOne('currentTime') || {};
        return t.time;
      },
      OrganisationCursor () {
        return Organisation.find({})
      },
      organisationIds: function() {
        return this.OrganisationCursor && this.OrganisationCursor.map((organisation) => organisation._id);
      }
    }
  }
</script>

<style scoped>
  p {
    font-size: 2em;
  }
</style>

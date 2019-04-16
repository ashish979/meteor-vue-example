<template>
  <div>
    <div v-if="!($subReady.Time && $subReady.Organisation)">Loading...</div>
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
      // Subscriptions - Errors not reported spelling and capitalization.
      $subscribe: {
        'Time': [],
        'Organisation': [],
        'OrganisationData': function() {
          return [this.organisationIds]
        }
      },
      // A helper function to get the current time
      currentTime () {
        console.log('Calculating currentTime');
        var t = Time.findOne('currentTime') || {};
        return t.time;
      },
      OrganisationCursor () {
        return Organisation.find({})
      },
      organisationIds () {
        var x = this.OrganisationCursor.map((organisation) => organisation._id);
        console.log(x);
        return x;
      }
    }
  }
</script>

<style scoped>
  p {
    font-size: 2em;
  }
</style>

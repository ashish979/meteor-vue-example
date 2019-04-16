# meteor-vue-example
This meteor app is created as per https://guide.meteor.com/vue.html

To replicate the issue raised https://github.com/meteor-vue/vue-meteor-tracker/issues/27, there is an `Organisation collection whose data is published.
Now there is another publication `OrganisationData` that depends on the array of organisation ids which is a meteor property in `App.vue`. 

As we add new Organisations, organisationIds are changed, and due to this `OrganisationData` publication should rerun. But it is not so.

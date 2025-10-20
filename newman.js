//function newmanTests() {

    const newman = require('newman');

newman.run({

    collection: require('Collections/FrameLabsCommunityGuideTesting.postman_collection.JSON'),
    reporters: 'cli'

}, function (err) {

	if (err) { throw err; }
    console.log('collection run complete!');

});

//}

//newmanTests();
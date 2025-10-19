const newman = require(newman);

newman.run({

    collection: require('./Collections/FrameLabsCommunityGuideTesting.postman_collection'),
    reporters: 'cli'

}, function (err) {

	if (err) { throw err; }
    console.log('collection run complete!');

});
const mongoose = require('mongoose');

const productReviewSchema = mongoose.Schema({
    buyerId: {
        type: 'string',
        required: true,
    },
    email: {
        type: 'string',
        required: true,
    },
    fullName: { 
        type: 'string', 
        required: true
    },
    productId: {
        type: 'string',
        required: true,
    },
    rating: {
        type: 'number',
        required: true,
    },
    review: {
        type: 'string',
        required: true,
    }
});

const ProductReview = mongoose.model('ProductReview',productReviewSchema);

module.exports = ProductReview;
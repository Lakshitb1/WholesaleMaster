const mongoose = require('mongoose');
const { productSchema } = require("./product");
const orderSchema = mongoose.Schema({
    products:[
        {
            product:productSchema,
            quantity:{
                type:Number,
                required:true,
            },
        }
    ],
    totalPrice:{
        type:Number,
    },
    address:{
        type:String,
        require:true,
    },
    userId:{
        required: true,
        type: String,
    },
    orderedAt:{
        type:Number,
        required:true,
    },
    status:{
        type:Number,
        ddefault:0,
    },
});

const Order = mongoose.model('Order',orderSchema);
module.exports = Order;
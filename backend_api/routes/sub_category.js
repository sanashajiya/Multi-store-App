const express = require('express');
const SubCategory = require('../models/sub_category');
const subCategory = require('../models/sub_category');
const subCategoryRouter = express.Router();

subCategoryRouter.post('/api/subCategories', async (req, res)=>{
    try {
        const {categoryId, categoryName, image, subCategoryName} = req.body;
        const subCategory = new SubCategory({categoryId, categoryName, image, subCategoryName});
        await subCategory.save();
        res.status(201).send(subCategory);
    } catch (e) {
        res.status(500).send({error: e.message});
    }
});

subCategoryRouter.get('/api/subcategories', async (req, res)=>{
    try {
        const subcategories = await SubCategory.find();
        res.status(200).json(subcategories);
    } catch (e) {
        res.status(500).send({error: e.message});
    }
});

subCategoryRouter.get('/api/category/:categoryName/subCategories', async (req, res)=>{
    try {
        // extract the categoryName from the request Url using Destructing
        const { categoryName } = req.params;
        const subCategories = await SubCategory.find({categoryName:categoryName});

        // check if any subcategory were found
        if(!subCategories || subCategories.length === 0) {
            // if no subcategories are found, response with a status code 404 error
            return res.status(404).json({msg: "subcategories  not found"});
        }
        else{
            // if subcategories are found, response with a status code 200 and the subcategories
            return res.status(200).json(subCategories);
        }
    } catch (e) {
        res.status(500).json({error:e.message})
    }
});
module.exports = subCategoryRouter;
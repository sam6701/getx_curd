import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecomerce/models/product_api.dart';
import 'package:getx_ecomerce/widgets/textfield_widget.dart';

class ModifyPage extends StatefulWidget {
  //final Product? product;
  final Function(Product) onProductSubmitted;
  final int list_size;
  final String title;
  final String ima;
  final double price;
  final Category cat;
  final String desc;
  final Rating rating;
  ModifyPage(
      {Key? key,
      required this.title,
      required this.ima,
      required this.cat,
      required this.desc,
      required this.price,
      required this.rating,
      required this.onProductSubmitted,
      required this.list_size})
      : super(key: key);

  @override
  _ModifyPageState createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  late TextEditingController _titleController;
  late TextEditingController _imageUrlController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;
  late TextEditingController _descriptionController;
  final globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Initialize text controllers with product data if available
    _titleController = TextEditingController();
    _imageUrlController = TextEditingController();
    _priceController = TextEditingController();
    _categoryController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose text controllers to avoid memory leaks
    _titleController.dispose();
    _imageUrlController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              TextFieldWidget(
                lText: 'Title',
                hiText: 'Enter Title',
                inputType: TextInputType.text,
                controll: _titleController,
              ),
              TextFieldWidget(
                lText: 'Image URL',
                hiText: 'Enter URL',
                inputType: TextInputType.url,
                controll: _imageUrlController,
              ),
              TextFieldWidget(
                lText: 'Category',
                hiText: 'Enter Category',
                inputType: TextInputType.text,
                controll: _categoryController,
              ),
              TextFieldWidget(
                lText: 'Description',
                hiText: 'Enter Description',
                inputType: TextInputType.text,
                controll: _descriptionController,
              ),
              TextFieldWidget(
                lText: 'Price',
                hiText: 'Enter Price',
                inputType: TextInputType.number,
                controll: _priceController,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Create a new product object with the updated data
                  //Category category = Category(name: _categoryController.text);
                  String categoryText = _categoryController.text.isEmpty
                      ? widget.cat.name
                      : _categoryController.text;
                  Category category =
                      CategoryExtension.fromString(categoryText) ??
                          Category.ELECTRONICS;
                  final updatedProduct = Product(
                      id: widget.list_size,
                      title: _titleController.text.isEmpty
                          ? widget.title
                          : _titleController.text,
                      price: _priceController.text.isEmpty
                          ? widget.price
                          : double.tryParse(_priceController.text) ??
                              widget.price,
                      image: _imageUrlController.text.isEmpty
                          ? widget.ima
                          : _imageUrlController.text,
                      category: category,
                      rating: Rating(
                          rate: widget.rating.rate, count: widget.rating.count),
                      description: _descriptionController.text.isEmpty
                          ? widget.desc
                          : _descriptionController.text);

                  // Call the onProductSubmitted callback with the updated product
                  widget.onProductSubmitted(updatedProduct);

                  // Navigate back to the previous screen
                  Get.back();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//https://images.pexels.com/photos/280250/pexels-photo-280250.jpeg?cs=srgb&dl=pexels-pixabay-280250.jpg&fm=jpg
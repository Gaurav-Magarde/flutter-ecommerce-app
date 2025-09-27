import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:clone_shopping/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/appbar/customAppBar.dart';
import '../../../userRepository/user_controller.dart';
import '../NameChangeController.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final nameController = Get.put(NameChangeController());
    return Scaffold(
      appBar: TAppBar(title: Text("Change Name"), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Form(
                key: nameController.nameFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("First Name",textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold),),
                    TextFormField(
                      controller: nameController.firstName,
                      validator: (value) => TValidator.validateEmptyText("First Name", value),
                      decoration: InputDecoration(
                        hintText: userController.user.value.firstName,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems,),
        
                    Text("Last Name",textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold),),
                    TextFormField(
                      controller: nameController.lastName,
                      validator: (value) =>
                        TValidator.validateEmptyText("Last Name", value)
        
                      ,
                      decoration: InputDecoration(
                        hintText: userController.user.value.lastName,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  nameController.saveName();
                }, child: Text("Save")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

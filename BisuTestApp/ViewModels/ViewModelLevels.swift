
import Foundation
import RxSwift

class ViewModelLevel1: BaseViewModel {
	var list1 = Variable<[ModelLevels]>([])
	var list2 = Variable<[ModelLevels]>([])
	var list3 = Variable<[ModelLevels]>([])
	var list4 = Variable<[ModelLevels]>([])
	
	override init() {
		super.init()
		list1.value = [ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),]
		
		list2.value = [ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),]
		
		list3.value = [ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),
					   ModelLevels(imageName: "photoE", imageId: 5, status: false),
					   ModelLevels(imageName: "photoF", imageId: 6, status: false),
					   ModelLevels(imageName: "photoE", imageId: 5, status: false),
					   ModelLevels(imageName: "photoF", imageId: 6, status: false),]
		
		list4.value = [ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),
					   ModelLevels(imageName: "photoE", imageId: 5, status: false),
					   ModelLevels(imageName: "photoF", imageId: 6, status: false),
					   ModelLevels(imageName: "photoE", imageId: 5, status: false),
					   ModelLevels(imageName: "photoF", imageId: 6, status: false),
					   ModelLevels(imageName: "photoG", imageId: 7, status: false),
					   ModelLevels(imageName: "photoH", imageId: 8, status: false),
					   ModelLevels(imageName: "photoG", imageId: 7, status: false),
					   ModelLevels(imageName: "photoH", imageId: 8, status: false),]
	}
}


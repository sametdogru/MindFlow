import Foundation
import RxSwift

class ViewModelLevels: BaseViewModel {
	var level1 = Variable<[ModelLevels]>([])
	var level2 = Variable<[ModelLevels]>([])
	var level3 = Variable<[ModelLevels]>([])
	var level4 = Variable<[ModelLevels]>([])
	
	override init() {
		super.init()
		level1.value = [ModelLevels(imageName:"photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),]
		
		level2.value = [ModelLevels(imageName:"photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),]
		
		level3.value = [ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoF", imageId: 6, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoE", imageId: 5, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),
					   ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoE", imageId: 5, status: false),
					   ModelLevels(imageName: "photoF", imageId: 6, status: false),]
		
		level4.value = [ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),
					   ModelLevels(imageName: "photoH", imageId: 8, status: false),
					   ModelLevels(imageName: "photoD", imageId: 4, status: false),
					   ModelLevels(imageName: "photoE", imageId: 5, status: false),
					   ModelLevels(imageName: "photoA", imageId: 1, status: false),
					   ModelLevels(imageName: "photoF", imageId: 6, status: false),
					   ModelLevels(imageName: "photoE", imageId: 5, status: false),
					   ModelLevels(imageName: "photoF", imageId: 6, status: false),
					   ModelLevels(imageName: "photoB", imageId: 2, status: false),
					   ModelLevels(imageName: "photoG", imageId: 7, status: false),
					   ModelLevels(imageName: "photoC", imageId: 3, status: false),
					   ModelLevels(imageName: "photoG", imageId: 7, status: false),
					   ModelLevels(imageName: "photoH", imageId: 8, status: false),]
	}
}


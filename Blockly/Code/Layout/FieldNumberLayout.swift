/*
 * Copyright 2016 Google Inc. All Rights Reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

/**
 Class for a `FieldNumber`-based `Layout`.
 */
@objc(BKYFieldNumberLayout)
public class FieldNumberLayout: FieldLayout {

  // MARK: - Properties

  /// The target `FieldNumber` to lay out
  public let fieldNumber: FieldNumber

  /// The current text value that should be used to render the `FieldNumber`.
  /// This value is automatically set to `self.fieldNumber.textValue` on initialization and 
  /// whenever `setValueFromLocalizedText(:)` is called.
  /// However, it can be set to any value outside of these calls (e.g. for temporary input
  /// purposes).
  public var currentTextValue: String {
    didSet {
      if currentTextValue != oldValue {
        updateLayoutUpTree()
      }
    }
  }

  // MARK: - Initializers

  public init(number: FieldNumber, engine: LayoutEngine, measurer: FieldLayoutMeasurer.Type) {
    self.fieldNumber = number
    self.currentTextValue = number.textValue
    super.init(field: number, engine: engine, measurer: measurer)
  }

  // MARK: - Public

  /**
   Convenience method that calls `self.fieldNumber.setValueFromLocalizedText(text)` and
   automatically sets `self.currentTextValue` to `self.fieldNumber.textValue`.
   */
  public func setValueFromLocalizedText(text: String) {
    fieldNumber.setValueFromLocalizedText(text)

    // Update `currentTextValue` to match the current localized text value of `fieldNumber`,
    // which will automatically update the corresponding view, if necessary.
    currentTextValue = fieldNumber.textValue
  }
}

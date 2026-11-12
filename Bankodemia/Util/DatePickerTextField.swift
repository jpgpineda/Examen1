//
//  DatePickerTextField.swift
//  Bankodemia
//
//  Created by javier pineda on 12/11/26.
//

import Foundation
import UIKit

final class DatePickerTextField: UITextField {
    var onDateSelected: ((Date) -> Void)?

    var maximumDate: Date? { didSet { datePicker.maximumDate = maximumDate } }
    var minimumDate: Date? { didSet { datePicker.minimumDate = minimumDate } }

    private let datePicker = UIDatePicker()

    // Los textfields de un XIB se crean con init(coder:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        inputView = datePicker
        inputAccessoryView = makeToolbar()
        tintColor = .clear // oculta el cursor
    }

    private func makeToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let cancel = UIBarButtonItem(systemItem: .cancel, primaryAction: UIAction { [weak self] _ in
            self?.resignFirstResponder()
        })
        let done = UIBarButtonItem(systemItem: .done, primaryAction: UIAction { [weak self] _ in
            guard let self else { return }
            self.onDateSelected?(self.datePicker.date)
            self.resignFirstResponder()
        })
        let spacer = UIBarButtonItem(systemItem: .flexibleSpace)

        toolbar.items = [cancel, spacer, done]
        return toolbar
    }

    /// Para precargar una fecha ya elegida
    func setPickerDate(_ date: Date) {
        datePicker.setDate(date, animated: false)
    }

    // El usuario solo elige con el picker: sin pegar, seleccionar ni cursor
    override func caretRect(for position: UITextPosition) -> CGRect { .zero }
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] { [] }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool { false }
}

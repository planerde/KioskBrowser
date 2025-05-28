import SwiftUI

struct SettingsView: View {
    @AppStorage("url") private var url: String = ""
    @AppStorage("clear_cache") private var clearCache: Bool = true
    @AppStorage("ReloadAfterErrorInSeconds") private var reloadAfterError: Int = 3

    @Environment(\.presentationMode) var presentationMode
    var onDismiss: (() -> Void)?

    let reloadOptions = [1, 3, 5, 10, 30, 60]

    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text(
                        NSLocalizedString("settings_url_section", comment: "URL section header")),
                    footer: Text(NSLocalizedString("settings_url_hint", comment: "URL hint"))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                ) {
                    TextField(
                        NSLocalizedString("settings_url_placeholder", comment: "URL placeholder"),
                        text: Binding(
                            get: { url },
                            set: { newValue in
                                if newValue.hasPrefix("www.") {
                                    url = "http://" + newValue
                                } else {
                                    url = newValue
                                }
                            }
                        ),
                        prompt: Text(
                            NSLocalizedString(
                                "settings_url_placeholder", comment: "URL placeholder"))
                    )
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                }
                Section(
                    header: Text(
                        NSLocalizedString(
                            "settings_options_section", comment: "Options section header"))
                ) {
                    Toggle(
                        NSLocalizedString("settings_clear_cache", comment: "Clear cache option"),
                        isOn: $clearCache)
                    Picker(
                        NSLocalizedString(
                            "settings_reload_after_error", comment: "Reload after error"),
                        selection: $reloadAfterError
                    ) {
                        ForEach(reloadOptions, id: \.self) { value in
                            Text("\(value)").tag(value)
                        }
                    }
                }
                HStack {
                    Spacer()
                    Button(
                        NSLocalizedString(
                            "settings_save_and_reload", comment: "Save and reload button")
                    ) {
                        presentationMode.wrappedValue.dismiss()
                        onDismiss?()
                    }
                    .disabled(!isValidURL(url))
                    Spacer()
                }
            }
            .navigationTitle(NSLocalizedString("settings_title", comment: "Settings title"))
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                    .help(
                        NSLocalizedString(
                            "settings_close_without_save", comment: "Close without saving help"))
                }
            }
        }
    }

    private func isValidURL(_ urlString: String) -> Bool {
        guard let url = URL(string: urlString) else { return false }
        return url.scheme == "http" || url.scheme == "https"
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
